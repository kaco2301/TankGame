using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class Bullet : MonoBehaviour
{
    float speed = 30f;
    
    void Start()
    {
        Destroy(gameObject, 2f);
    }


    void Update()
    {
        float amount = speed * Time.deltaTime;
        transform.Translate(Vector3.forward * amount);

    }

    private void OnCollisionEnter(Collision collision)
    {
        Debug.Log("OnCollisionEnter() is occurred . . . ");
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Target")
        {
            //����+10
            //Ÿ��������ƼŬ
            //Ÿ�����Ż���
            //Ÿ������
            //Destroy(other.gameObject);
            if (other.tag == "Enemy")
            {
                other.transform.root.SendMessage("DestroySelf", transform.position);
            }
            Destroy(gameObject);
            //other.GetComponent<TargetDestroy>().DestroySelf(transform.position);

        }
        //�Ѿ�����
        Destroy(gameObject);
        
    }
}

