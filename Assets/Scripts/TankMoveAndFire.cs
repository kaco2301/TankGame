using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;//legacytext 사용위함
using TMPro;


public class TankMoveAndFire : MonoBehaviour
{
    public Transform spPoint;
    public Transform bullet;
    public GameObject explosion;//탱크 폭파시 이펙트
    public Text countText;
    public TMP_Text HPtext;
    public GameObject GetItemEffect;
    public GameObject Gas;
    float spawnmin = 5f;
    float spawnmax = 5f;


    Rigidbody rgBody;
    GameObject fire;

    float moveSpeed = 10f;//
    float rotSpeed = 60f;//
    //float delayTime = 0.1f;
    bool canFire = true;
    AudioSource[] gunSound;

    int hp = 10;
    int score = 0;
    int itemCount = 4;



    // Start is called before the first frame update
    void Start()
    {
        spPoint = GameObject.Find("SpawnPoint").transform;
        fire = GameObject.Find("FireEffect");
        fire.SetActive(false);
        //gunSound = GetComponent<AudioSource>();//단수
        gunSound = GetComponents<AudioSource>();//복수(배열)

        rgBody = GetComponent<Rigidbody>();
        countText.text = "HP: " + hp.ToString();


    }

    // Update is called once per frame
    void Update()
    {



        /*쉬프트 키를 누르면 빨라짐
                if (Input.GetKey(KeyCode.LeftShift))
                {
                    transform.Translate(Vector3.forward * amount * vert * 2);
                    transform.Rotate(Vector3.up * amountRot * horz * 2);
                }
                else
                {
                    transform.Translate(Vector3.forward * amount * vert);
                    transform.Rotate(Vector3.up * amountRot * horz);
                }
                */

        if (Input.GetButtonDown("Fire1"))
        {
            SingleShot();
        }
        /*if(Input.GetButton("Fire2")&&canFire)
        {
            StartCoroutine(AutoFire2());
        }
        */

        if (Input.GetKey(KeyCode.LeftShift) && canFire)
        {
            StartCoroutine(AutoFire2());
        }
        if (!Input.GetKey(KeyCode.LeftShift))
        {
            gunSound[1].Stop();
        }
        /*if(Input.GetButtonUp("Fire2"))
        {
            gunSound[1].Stop();//연속발사 버튼을 떼었을때, 사운드효과를 제거.
        }*/


    }

    void FixedUpdate()
    {
        float vert = Input.GetAxis("Vertical");
        float horz = Input.GetAxis("Horizontal");
        float amount = moveSpeed * Time.deltaTime * vert;
        float amountRot = rotSpeed * Time.deltaTime * horz;

        rgBody.MovePosition(rgBody.position + transform.forward * amount);
        rgBody.MoveRotation(rgBody.rotation * Quaternion.Euler(Vector3.up * amountRot));

        //transform.Translate(Vector3.forward * amount * vert);
        //transform.Rotate(Vector3.up * amountRot * horz); 위 문장이랑 뭔차인지 알아오기





    }



    void SingleShot()
    {
        Instantiate(bullet, spPoint.position, spPoint.rotation);
        //gunSound.Play(); 단수
        gunSound[0].Play();
        fire.SetActive(true);


    }
    IEnumerator AutoFire2()
    {
        Instantiate(bullet, spPoint.position, spPoint.rotation);
        canFire = false;

        yield return new WaitForSeconds(0.1f);
        canFire = true;
        gunSound[1].Play();//연발소리 추가
        fire.SetActive(true);
        //5.9
        //연발 이펙트적용해오기
        //3장 86p 연속이미지 sprite editor 해보기.


    }

    /*void AutoFire()
    {
        delayTime += Time.deltaTime;
        if (delayTime > 0.1f)
        {


            Instantiate(bullet, spPoint.position, spPoint.rotation);
            delayTime = 0;
        }
    }*/

    private void OnCollisionEnter(Collision collision)
    {
        Debug.Log("OnCollisionEnter()함수 발생");
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Bullet")
        {
            hp--;
            countText.text = "HP: " + HPtext.ToString();
            if (hp < 0)
            {
                StartCoroutine(DestroySelf());
            }
        }
        if (other.tag == "Item10")
        {
            score += 10;
            Debug.Log(score + "점입니다.");
            Instantiate(GetItemEffect, transform.position, Quaternion.identity);
            DestroyItem(other.gameObject);

            if (CountItems() <itemCount)
            {
                //SpawningItem();
                Debug.Log("아이템 생성한다이");
            }
        }
        if (other.tag == "Item20")
        {
            score += 20;
            Debug.Log(score + "점입니다.");
            Instantiate(GetItemEffect, transform.position, Quaternion.identity);
            DestroyItem(other.gameObject);
        }
        //점수 오르는것
        //부딪힌 아이템 오브젝트 제거
        //파티클 추가
        //사운드


    }

    IEnumerator DestroySelf()
    {
        Instantiate(explosion, transform.position, Quaternion.identity);
        yield return new WaitForSeconds(2f);
        SceneManager.LoadScene("MainScene");

    }

    public void DestroyItem(GameObject item)
    {
        Destroy(item);
        //SpawningItem();
    }

    private int CountItems()
    {
        GameObject[] items = GameObject.FindGameObjectsWithTag("Item10");
        Debug.Log(items.Length-1);
        return items.Length-1;
        
    }
    /*private void SpawningItem()
    {
        float spawnX = Random.Range(spawnmin, spawnmax);
        float spawnZ = Random.Range(spawnmin, spawnmax);
        Vector3 SpawnPosition = new Vector3(spawnX, 0, spawnZ);
        GameObject newItem = Instantiate(Gas, SpawnPosition, Quaternion.identity);
        newItem.tag = "Item10";


    }*/
}

